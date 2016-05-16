class SubjectsController < ApplicationController

	layout "admin"
	
	def index
		@subjects = Subject.sorted
	end

	def show
		@subject = Subject.find(params[:id])
	end

	def new
		@subject = Subject.new({:name => "Default"})
		@subject_count = Subject.count + 1
	end
	
	def create
		@subject_count = Subject.count
		if @subject.save
			flash[:notice] = "Subject created succesfully."
			redirect_to(:action => 'index')
		else
			@subject = Subject.new(subject_params)
			render('new')
		end
	end

	def edit
		@subject = Subject.find(params[:id])
		@subject_count = Subject.count
	end
	
	def update
		@subject = Subject.find(params[:id])
		if @subject.update_attributes(subject_params)
			flash[:notice] = "Subject updated succesfully."
			redirect_to(:action => 'show', :id => @subject.id)
		else
			@subject_count = Subject.count
			render('edit')
		end
	end

	def delete
		@subject = Subject.find(params[:id])
	end
	
	def destroy		
		subject = Subject.find(params[:id]).destroy
		flash[:notice] = "Subject '#{subject.name}' destroyed succesfully."
		redirect_to(:action => 'index')
	end
	
	private
		def subject_params
			#same as using "params[:subject]", excpet that it
			# - raises an error if :subject is not present
			# - allows listed attributes to be mass-assigned
			params.require(:subject).permit(:name, :position, :visible, :created_at)
		end
end
