AdminUser.create!(email: 'admin@example.com', password: 'password123')
User.create!(email: 'prayer@gmail.com', password: 'pray1234')
Prayer.create!(
  text: 'Our Father, who art in heaven
    Hallowed be thy Name,
    Thy kingdom come,
    Thy will be done, on earth as it is in heaven.
    Give us this day our daily bread
    And forgive us our trespasses, as we forgive those who trespass against us.
    And lead us not into temptation, but deliver us from evil.
    For thine is
    The kingdom,
    And the power,
    And the glory,
    For ever and ever.
    Amen.',
  description: 'Pray for me!',
  is_free: true,
  is_published: false
)

Prayer.create!(
  text: 'Test prayer',
  description: 'Play for peace',
  is_free: false,
  is_published: false
)
