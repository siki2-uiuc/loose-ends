class PetsController < ApplicationController

  before_action :set_pet, only: [:show, :edit, :destroy, :update]

  def set_pet
    @pet = Pet.find(params.fetch("id"))
  end

  def new
    @pet = Pet.new
  end

  def edit
    @pet = Pet.find(params.fetch("id"))
  end

  def index
    matching_pets = Pet.all

    @list_of_pets = matching_pets.order({ :created_at => :desc })
    

    respond_to do |format|
      # Implicitly happening
      
      format.html do
        render("pets/index.html.erb")
      end

      format.json do 
        render json: @list_of_pets
      end

    end




    # render({ :template => "pets/index.html.erb" })
  end

  def show
    # the_id = params.fetch("path_id")

    # matching_pets = Pet.where( id: the_id )

    # @the_pet = matching_pets[0]

    # adding ! throws "Record not found" error if id doesn't exist in db
    @pet = Pet.find( params.fetch("id") )


    # Assumes you are referencing an html page so adding html.erb path isn't necessary
    # render({ :tmeplate => "pets/show.html.erb"})

    # render template: "pets/show"
    
    # render("pets/show")

    # render("show")

    # Render statements are not necessary if the controller method matches name of view page

  end

  def create
    # @pet = Pet.new
    # @pet.name = params.fetch(:name)
    # @pet.age = params.fetch(:age)
    # @pet.species_id = params.fetch(:species_id)

    pet_params = params.require(:pet_attributes).permit(:age, :name, :species_id)
    @pet = Pet.new(pet_params)

    if @pet.valid?
      @pet.save
      redirect_to("/pets", { :notice => "Pet created successfully." })
    else
      # redirect_to("/pets/new", { :alert => @pet.errors.full_messages.to_sentence })

      render("new")
    end
  end

  def update
    # the_id = params.fetch("path_id")
    # @pet = Pet.find(params.fetch("id"))

    # @pet.name = params.fetch("query_name")
    # @pet.age = params.fetch("query_age")
    # @pet.species_id = params.fetch("query_species_id")

    pet_params = params.require(:pet).permit(:age, :name, :species_id)

    @pet.update(pet_params)

    if @pet.valid?
      @pet.save
      redirect_to("/pets/#{@pet.id}", { :notice => "Pet updated successfully."} )
    else
      render("edit")
    end
  end

  def destroy
    # the_id = params.fetch("path_id")
    @pet = Pet.find(params.fetch("id"))

    @pet.destroy

    redirect_to("/pets", { :notice => "Pet deleted successfully."} )
  end
end
