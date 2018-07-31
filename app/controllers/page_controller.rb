class PageController < ApplicationController
  require 'we_transfer_client'

  def root
  end

  def upload
    client = WeTransferClient.new(api_key: ENV.fetch('WT_API_KEY'))
    Retryable.retryable(tries: :infinite) do
      transfer = client.create_transfer(name: "My wonderful transfer", description: "I'm so excited to share this") do |upload|
        upload.add_file_at(path: params['file'].tempfile.path)
      end
    end
    redirect_to root_path, notice: transfer.shortened_url
  end
end
