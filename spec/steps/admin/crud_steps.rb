step '後台建立 :model_name:' do |model_name, last_params = nil|
  sign_in_admin
  set_previous_count(model_name)
  to_params_list(last_params).each do |hash|
    params = build_params(model_name, hash, traits: [:admin_creation])
    post Bdd::AdminRouter.build_url("/#{model_name.to_s.pluralize}"), params: params
  end
end

step '後台更新 :model_finder:' do |instance, last_params|
  sign_in_admin
  model_name = to_model_name(instance.class)
  instance_variable_set("@#{model_name}", instance)
  hash = to_params_list(last_params)[0]
  params = build_params(model_name, hash)
  put Bdd::AdminRouter.build_url("/#{model_name.to_s.pluralize}/#{instance.id}"), params: params
end

step '後台刪除 :model_finder' do |instance|
  sign_in_admin
  model_name = to_model_name(instance.class)
  instance_variable_set("@#{model_name}", instance)
  delete Bdd::AdminRouter.build_url("/#{model_name.to_s.pluralize}/#{instance.id}")
end

step '後台還原 :model_finder' do |instance|
  sign_in_admin
  model_name = to_model_name(instance.class)
  instance_variable_set("@#{model_name}", instance)
  post Bdd::AdminRouter.build_url("/#{model_name.to_s.pluralize}/#{instance.id}/restore")
end
