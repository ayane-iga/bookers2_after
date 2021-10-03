class Book < ApplicationRecord

	belongs_to :user
	validates :body, length:{maximum:200}
    validates :body, presence: true
    validates :title, presence: true
<<<<<<< HEAD

    has_many :favorites, dependent: :destroy
    has_many :book_comments, dependent: :destroy

    def favorited_by?(user)
    	favorites.where(user_id: user.id).exists?
    end

    #@book.favorited_by?(current_user)

    def self.search(search,content)
        if search == "forward_match"
            @book = Book.where("title LIKE?", "#{content}%")
        elsif search == "backward_match"
            @book = Book.where("title LIKE?", "%#{content}")
        elsif search == "perfect_match"
            @book = Book.where("#{content}")
        elsif search == "pertial_match"
            @book = Book.where("title LIKE?", "%#{content}%")
        else
            @book = Book.all
        end
    end
=======
>>>>>>> origin/master
end
