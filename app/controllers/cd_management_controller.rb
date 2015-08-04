class CdManagementController < ApplicationController
  
  def home_index
    @artists = Artist.all
    search_data = params[:query]? params[:query][:search] : ""
    if !search_data.blank?
      search      
    end    
  end
  
  def search
    choice = params[:query][:choice]
    data = params[:query][:data]    
    if !data.blank?
      @artists = []
      @artists = Artist.where("first_name LIKE ? OR last_name LIKE ? ", "%#{data}%", "%#{data}%") if choice =="Artist"      
      if choice =="Album" || choice =="Record label"
         Album.where("title_name LIKE ? OR record_label LIKE ?", "%#{data}%", "%#{data}%").each do |a|           
           @artists << Artist.find(a.artist_id)
         end
      end
      if choice.blank?
        @artists = Artist.where("first_name LIKE ? OR last_name LIKE ? ", "%#{data}%", "%#{data}%") if choice.blank?        
        if @artists.empty?
          Album.where("title_name LIKE ? OR record_label LIKE ?", "%#{data}%", "%#{data}%").each do |a|           
           @artists << Artist.find(a.artist_id)
         end
        end
      end    
    end    
  end
  
  def add_edit_artist
    @mode = params[:query][:mode]
    if @mode == "Edit"
      @artist = Artist.find(params[:query][:id])
    end
    if request.post?
      return flash[:error] = "The entered mobile number had digits less than 10." if params[:query][:mobile].length < 10      
      if @mode =="Add"              
        add_new_artist
      elsif @mode =="Edit"
        artist = params[:query][:artist]
        edit_artist(artist)
      end
    end
  end
  
  def add_new_artist
    Artist.create(
    first_name: params[:query][:first_name],
    last_name: params[:query][:last_name],
    email: params[:query][:email],
    mobile_number: params[:query][:mobile],
    country: params[:query][:country])
    redirect_to home_index_path(), notice: "You have succesfully Added a new Artist."
  end
  
  def artist_info
    @artist = Artist.find(params[:query][:id])
    @artist_album = []
    Album.where("artist_id =?", @artist.id).each do |a|
      @artist_album << a
    end
  end
  
  def add_edit_album
    @artist = Artist.find(params[:query][:id])
    @mode = params[:query][:mode]    
    if @mode=="Edit"
     @album = Album.find(params[:query][:album_id])
    end
    if request.post?
      assign
      error = validate
      return flash[:error] = error if !error.blank? && error != nil
      add_album if @mode=="Add"
      edit_album if @mode=="Edit"
    end
  end
  
  def assign
    @title_name = params[:query][:title_name]
    @no_of_songs = params[:query][:no_of_songs]
    @cost_amount = params[:query][:cost_amount]
    @record_label = params[:query][:record_label]
    year = params[:query]["release_date(1i)"]
    month = params[:query]["release_date(2i)"]
    day = params[:query]["release_date(3i)"]
    @releae_date = "#{year}-#{month}-#{day}"    
  end
  
  def validate
    return msg ="Please provide Title Name" if @title_name.blank? || @title_name == nil
    return msg ="Please provide Number of songs the album has" if @no_of_songs.blank? || @no_of_songs == nil
    return msg ="Please provide the cost amount" if @cost_amount.blank? || @cost_amount == nil
    return msg ="Please provide the Record Label Name" if @record_label.blank? || @record_label == nil    
  end
  
  def add_album
    date = Time.now    
    @artist.albums.create(
    title_name: @title_name,
    number_of_songs: @no_of_songs,
    cost_amount: @cost_amount,
    record_label: @record_label,
    release_date: @releae_date,
    created: date,
    updated: date)
    
    redirect_to artist_info_path(query:{id: @artist.id}), notice: "#{@artist.first_name} #{@artist.last_name}'s album was successfully added!"
  end
  
  def edit_album
    date = Time.now
    @album.update_attributes!(
      title_name: @title_name,
      number_of_songs: @no_of_songs,
      cost_amount: @cost_amount,
      record_label: @record_label,
      release_date: @releae_date,
      updated: date
    )
    
    redirect_to artist_info_path(query:{id: @artist.id}), notice: "#{@artist.first_name} #{@artist.last_name}'s album was successfully updated!"
  end
  
  def delete_artist
    Album.where("artist_id", params[:query][:id]).destroy_all
    Artist.find(params[:query][:id]).destroy
     redirect_to home_index_path(), notice: "Artist was deleted."
  end
end
