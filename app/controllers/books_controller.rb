class BooksController < ApplicationController

before_action :authenticate_user!
before_action :correct_user, only:[:edit, :update]

	def new
		@hon = Book.new
	end

	def create
		@hon = Book.new(book_params)
		@hon.user_id = current_user.id
		@books = Book.all
		if @hon.save
			flash[:notice] = "Book was successfully created"
		    redirect_to book_path(@hon.id)
		else
			render :index
		end
	end

	def show
		@hon = Book.new
		@book = Book.find(params[:id])
		@user = @book.user
		@book_comment = BookComment.new
		@book_comments = BookComment.all
	end

	def update
		@book =Book.find(params[:id])
		if @book.update(book_params)
			flash[:notice] = "Book was successfully created"
		    redirect_to book_path(@book.id)
        else render action: :edit
        end
	end

	def index
		@books = Book.all
		@hon = Book.new

	end

	def edit
		@book = Book.find(params[:id])
	end

	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to book_path
	end

private
def book_params
	params.require(:book).permit(:title, :body, :user)
end

def correct_user
    @user = current_user.books.find_by(id: params[:id])
    unless @user
      redirect_to books_path
    end
  end

end


