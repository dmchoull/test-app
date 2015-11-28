include FactoryGirl::Syntax::Methods

# Admin

admin_role = Role.create!(name: 'admin')

admin_user = create(:user, email: 'admin@example.com', password: 'password')
admin_user.roles << admin_role

# Regular user with profile

regular_user = create(:user, email: 'jdoe@example.com', password: 'password')

profile = build(:profile, user: regular_user)
profile.bio = <<BIO
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum sit amet posuere felis. Nam eget quam risus. Cras lobortis egestas tellus, vel ullamcorper justo finibus eget. Donec tellus tellus, feugiat a nunc non, fringilla dignissim ipsum. Nunc nec nunc imperdiet, interdum odio ac, interdum tortor. In tincidunt diam nulla. In malesuada sagittis nulla, quis ornare felis lacinia vitae. Aliquam ultricies dignissim lectus sed suscipit. Mauris imperdiet est gravida orci iaculis, sed fermentum mauris consectetur. Pellentesque sapien purus, rutrum eget dolor ac, elementum sollicitudin nibh. Sed pulvinar, orci non consequat ullamcorper, tellus mi gravida orci, fermentum sagittis ipsum velit at sem. Sed rutrum risus id metus pellentesque, ut efficitur orci pellentesque. Praesent velit mi, faucibus nec ex at, blandit molestie odio.

Quisque ut blandit nibh. Ut mollis ex sapien. Nunc vel faucibus dolor. Ut vehicula id tortor vitae ultricies. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer quis congue elit. Sed feugiat quam ac elit tristique, in congue lectus pretium. Donec id feugiat libero. Praesent bibendum, massa in mattis sodales, neque eros hendrerit enim, et consectetur magna mi at ex.
BIO
profile.save!
