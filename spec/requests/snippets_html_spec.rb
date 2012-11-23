require 'spec_helper'

describe "Snippets" do
  def prepare_snippet
    Snippet.create(:source => 'tag(:img)')
  end

  describe 'get show' do
    context 'with no data' do
      it {
        expect {
          get '/snippets/1'
        }.to raise_error(ActiveRecord::RecordNotFound)
      }
    end
    context 'with valid data' do
      before {
        prepare_snippet
        get '/snippets/1'
      }
      it {
        response.status.should == 200
      }
    end
  end

  describe 'get index' do
    before {
      get '/snippets/'
    }
    it {
      response.should redirect_to('/')
    }
  end

  shared_context 'create valid' do
    before {
      visit '/'
      fill_in 'snippet_source', :with => 'tag(:img)'
      click_button 'Create Snippet'
    }
    it {
      current_path.should == '/snippets/1'
    }
    it {
      page.should have_selector('textarea#snippet_source')
    }
    it {
      page.should have_content('tag(:img)')
    }
    it {
      page.should have_content('<img />')
    }
  end

  shared_context 'create invalid' do
    before {
      visit '/'
      fill_in 'snippet_source', :with => 'tag'
      click_button 'Create Snippet'
    }
    it {
      current_path.should == '/snippets/1'
    }
    it {
      page.should have_content('wrong number of arguments')
    }
  end

  describe 'create' do
    context 'valid' do
      include_context 'create valid'
    end
    context 'invalid' do
      include_context 'create invalid'
    end
  end

  describe 'update' do
    include_context 'create valid'
    context 'update valid' do
      before {
        fill_in 'snippet_source', :with => 'tag(:a)'
        click_button 'Update Snippet'
      }
      it {
        page.should have_content('<a />')
      }
    end
    context 'update invalid' do
      before {
        fill_in 'snippet_source', :with => 'a'
        click_button 'Update Snippet'
      }
      it {
        page.should have_content("undefined local variable or method `a'")
      }
    end
  end
end
