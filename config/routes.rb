Rails.application.routes.draw do
  post '/upload', to: 'page#upload'
  root 'page#root'
end

