Rails.application.routes.draw do
  scope Doculab.route_namespace, :module => "doculab" do
    match ':permalink' => 'docs#show', :as => "doculab_doc"
    root :to => 'docs#index', :as => "doculab_root"
  end
end
