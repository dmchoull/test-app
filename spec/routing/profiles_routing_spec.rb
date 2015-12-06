describe ProfilesController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: '/users/1/profile').to route_to('profiles#show', user_id: '1')
    end

    it 'routes to #create' do
      expect(post: '/users/1/profile').to route_to('profiles#create', user_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/users/1/profile').to route_to('profiles#update', user_id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/users/1/profile').to route_to('profiles#update', user_id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/users/1/profile').to route_to('profiles#destroy', user_id: '1')
    end
  end
end
