require 'test_helper'

class ProductTest < ActiveSupport::TestCase
   test ("product attributes must not be blank")  do
		product = Product.new
		assert product.invalid?, "ok"
		assert product.errors[:title].any?
		assert product.errors[:description].any?
		assert product.errors[:image_url].any?
		assert product.errors[:price].any?
	end
	
	test ("product price must be positive")  do
		product = Product.new(:title => "My Book Title" ,
							:description => "yyy" ,
							:image_url => "zzz.jpg" )
		# invalid value for the price
		product.price = -1
		assert product.invalid?
		assert_equal "must be greater than or equal to 0.01" ,
			product.errors[:price].join('; ' )
		# invalid value for the price
		product.price = 0
		assert product.invalid?
		assert_equal "must be greater than or equal to 0.01",
			product.errors[:price].join('; ')
		# valid value
		product.price = 1
		assert product.valid?
	end

	def new_product(image_url)
		Product.new(:title => 'book',
					:description => 'book',
					:price => 1,
					:image_url => image_url)
	end

	test 'test image url' do
		ok = %w{test.gif test.jpg test.png Test.JPG TEST.jPG
			http://a.b.c/xy/x.test.jpg}
		bad = %w{ test.doc test.gif/more test.gif.more}
		ok.each do |name|
			assert new_product(name).valid?
		end
		bad.each do |name|
			assert new_product(name).invalid?, 'bad'
		end
	end

end
