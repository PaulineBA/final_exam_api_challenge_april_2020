Rspec.describe 'POST /api/comments', type: :request do 
 describe 'with valid credentials' do 
  let!(:user) { create(:user)}
  let(:user_credentials) {user.create_new_auth_token}
  let(:user_headers) do
{ HTTP_ACCEPT: 'application/json'}.merge!(user_credentials)
end

let!(:article) { create(:article)}

describe 'User can comment article' do 
before do 
  post '/api/comments',
  params: {
    comment:{
      body: 'This final exam is sooo fraking stressful '
      article_id: article.id,
      user_id: user.id
    }
  }
  header: user_headers
end
it 'returns a 200 response' do 
expect(response). to have_http_status 200
end

it 'returns success message' do 
expect(response_json['message']). to eq 'Comment successfully posted!'
end
end

describe 'User cannot post blanck comment' do 
before do
  post '/api/comments',
  params: {
    comment:{
      body: 'This final exam is sooo fraking stressful '
      article_id: article.id,
      user_id: user.id
    }
  }
  header: user_headers
end

it 'returns a 400 response'do 
expect(.response).to have_http_status 400
end

it 'returns error message' do
  expect(response_json).to eq 'Something wrong happened!'
    end
  end
end

describe 'without valid credentials' do 
  let!(:user) { create(:user)}
  let(:user_headers) do
    { HTTP_ACCEPT: 'application/json'}
  end 
    before do
      post '/api/comments',
      params: {
        comment:{
          body: 'This final exam is sooo fraking stressful '
          article_id: article.id,
          user_id: user.id
        }
      }
    end 
    it 'returns 401 status' do 
    expect(response).to have_http_status 401
    end

    it'returns error message' do 
      expect(response_json).to eq 'You need to sign in to be able to comment'
    end 
  end
end