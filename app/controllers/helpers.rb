module Helpers

  def url_path(payload_full_path)
    "/sources/#{@user.identifier}/urls/#{relative_path(payload_full_path)}"
  end

  def event_path(event)
    "/sources/#{@user.identifier}/events/#{event}"
  end

  def relative_path(payload_full_path)
      payload_full_path.split('/')[3..-1].join
  end

  def user(id)
    @user = TrafficSpy::User.find_by(identifier: id)
  end

  def stats_viewing(id)
    if @user.payloads.count == 0
      erb :no_payload_data, locals: {id: id}
    else
      erb :'application_stats_index/application_statistics'
    end
  end

  def full_path(relative_path)
    @user.root_url + '/' + relative_path
  end
end