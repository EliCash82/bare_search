#Simple Search

This is a very basic Ruby on Rails app that uses a very simple search.

I'd been using Sunspot, a SOLR powered search gem, for my local database collections
and realized that moving forward with some of my projects I need to have a better understanding/
grasp over my searching mechanism.

This is very basic:

- I generated a new rails application

- I created a simple scaffold

- I added twitter-bootstrap-rails gem, therubyracer gem, and less-rails gem

- I followed the bulk of the instructions suggested on this page: [http://www.jorgecoca.com/buils-search-form-ruby-rails](http://www.jorgecoca.com/buils-search-form-ruby-rails)

---

The following are changes made from the original generated scaffold:

```HTML.ERB

<!-- application.html.erb -->

<!DOCTYPE html>
<html>
<head>
  <title>Bootsy</title>
  <%= stylesheet_link_tag    "application", media: "all", "data-turbolinks-track" => true %>
  <%= javascript_include_tag "application", "data-turbolinks-track" => true %>
  <%= csrf_meta_tags %>
</head>
<body>

  <%= form_tag(comics_path, :method => "get", class: "navbar-form", id: "search-form") do %>
    <div class="input-append">
      <%= text_field_tag :search, params[:search], class: "span2", placeholder: "Search Comics" %>
      <button class="btn" type="submit"><i class="icon-search"></i></button>
    </div>
  <% end %>

  <%= yield %>

</body>
</html>


```Ruby
#comic.rb

class Comic < ActiveRecord::Base


  validates :name, presence: true, uniqueness: true
  validates :summary, presence: true, uniqueness: true
  validates :issue, presence: true, uniqueness: true

  def self.search(query)
    where("name like ?", "%#{query}%")
  end

end

```

```Ruby

#comics_controller

class ComicsController < ApplicationController
  before_action :set_comic, only: [:show, :edit, :update, :destroy]

  # GET /comics
  # GET /comics.json
  def index
    if params[:search]
      @comics = Comic.search(params[:search]).order("created_at DESC")
    else
      @comics = Comic.order("created_at DESC")
    end
  end

  # GET /comics/1
  # GET /comics/1.json
  def show
  end

  # GET /comics/new
  def new
    @comic = Comic.new
  end

  # GET /comics/1/edit
  def edit
  end

  # POST /comics
  # POST /comics.json
  def create
    @comic = Comic.new(comic_params)

    respond_to do |format|
      if @comic.save
        format.html { redirect_to @comic, notice: 'Comic was successfully created.' }
        format.json { render action: 'show', status: :created, location: @comic }
      else
        format.html { render action: 'new' }
        format.json { render json: @comic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comics/1
  # PATCH/PUT /comics/1.json
  def update
    respond_to do |format|
      if @comic.update(comic_params)
        format.html { redirect_to @comic, notice: 'Comic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @comic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comics/1
  # DELETE /comics/1.json
  def destroy
    @comic.destroy
    respond_to do |format|
      format.html { redirect_to comics_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comic
      @comic = Comic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comic_params
      params.require(:comic).permit(:name, :issue, :summary)
    end
end

```

```HTML

<% @comics.each do |comic| %>
  <div class="comic">
    <h1 class="comic-name"><%= link_to comic.name, comic %></h1>
    <p class="comic-content"><%= comic.summary %>
  </div>
<% end %>

<br>

<%= link_to 'New Comic', new_comic_path %>


```


From here I plan to look more closely at Railscast 343 and update this functionality to be PostGRES grounded search.  

We'll see how that goes.
