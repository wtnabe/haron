require 'spec_helper'

describe "Snippets" do
  def new_snippet
    {:source => 'tag(:img)'}
  end

  def prepare_snippet
    Snippet.create(:source => 'tag(:img)')
  end

  describe 'get show' do
    context 'with no data' do
      it {
        expect {
          get '/snippets/1.json'
        }.to raise_error(ActiveRecord::RecordNotFound)
      }
    end
    context 'with valid data' do
      before {
        prepare_snippet
        get '/snippets/1.json'
      }
      it {
        response.status.should == 200
      }
    end
  end

  describe 'get index' do
    before {
      get '/snippets.json'
    }
    it {
      response.status.should == 404
    }
  end

  shared_context 'create successfully' do
    before {
      post '/snippets.json', :snippet => new_snippet
    }
    it {
      response.status.should == 201 # created
    }
    it {
      response.header['Location'].should == 'http://www.example.com/snippets/1'
    }
    it {
      JSON.parse(response.body)['status'].should == 'success'
    }
  end

  shared_context 'create unsuccessfully' do
    before {
      post '/snippets.json', :snippet => {:source => 'tag'}
    }
    it {
      response.header['Location'].should == 'http://www.example.com/snippets/1'
    }
    it {
      response.status.should == 201 # created
    }
    it {
      JSON.parse(response.body)['status'].should == 'fail'
    }
  end

  describe 'create' do
    context 'valid' do
      include_context 'create successfully'
    end
    context 'invalid' do
      include_context 'create unsuccessfully'
    end
  end

  describe 'update' do
    context 'update successfully' do
      before {
        prepare_snippet
        put '/snippets/1.json', :snippet => {:source => 'tag(:a)'}
      }
      it {
        response.status.should == 200
      }
      it {
        JSON.parse(response.body)['status'].should == 'success'
      }
    end
    context 'update unsuccessfully' do
      before {
        prepare_snippet
        put '/snippets/1.json', :snippet => {:source => 'a'}
      }
      it {
        response.status.should == 200
      }
      it {
        JSON.parse(response.body)['status'].should == 'fail'
      }
    end
  end
end
