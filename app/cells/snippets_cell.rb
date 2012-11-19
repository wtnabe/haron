class SnippetsCell < Cell::Rails
  def new
    @snippet = Snippet.new

    render
=begin
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @snippet }
    end
=end
  end

  def edit
    @snippet = Snippet.find(params[:id])

    render
  end

  def show
    @snippet = Snippet.find(params[:id])

    render
  end
end
