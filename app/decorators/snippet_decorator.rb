# coding: utf-8
module SnippetDecorator
  def converted
    begin
      @status = 'success'
      eval(self.source).to_str
    rescue => e
      @status = 'fail'
      e.to_s
    end
  end

  def status
    @status
  end
end
