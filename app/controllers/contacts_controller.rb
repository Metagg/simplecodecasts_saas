class ContactsController < ApplicationController
    def new
      @contact = Contact.new
    end
    
    def create
      @contact = Contact.new(contact_params)
      
      # save contact data into database
      if @contact.save
        name = params[:contact][:name]
        email = params[:contact][:email]
        body = params[:contact][:comments]
        
        ContactMailer.contact_email(name, email, body).deliver
        flash[:success] = 'Message sent.'
        redirect_to new_contact_path
      else
        flash[:danger] = 'Error occured, message has not been sent.'
        redirect_to new_contact_path
      end
    end
    
    private
    # white list for security. Very important
      def contact_params
        params.require(:contact).permit(:name, :email, :comments)  
      end
end