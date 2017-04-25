module AuthenticationHelper
  def stub_authentication
    allow_any_instance_of(ApplicationController).to receive(:authenticate).and_return(true)
  end
end
