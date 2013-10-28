class Spree::Admin::RedirectsController < Spree::Admin::ResourceController

  def new
    @redirect = Spree::Redirect.new
    render :layout => !request.xhr?
  end
    
  private
    
    def collection
      params[:q] ||= {}
      @search = Spree::Redirect.ransack(params[:q])
      @search.sorts = params[:q][:s] ||= "old_url.asc"
      @collection = @search.result.page(params[:page]).per(Spree::Config[:orders_per_page])
    end

end
