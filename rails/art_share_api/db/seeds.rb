# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u1 = User.create!({ username: 'user1' })
u2 = User.create!({ username: 'user2' })
u3 = User.create!({ username: 'user3' })
u4 = User.create!({ username: 'user4' })
u5 = User.create!({ username: 'user5' })

a1 = Artwork.create!({ title: 'title1', img_url: 'url1', artist_id: u1.id })
a2 = Artwork.create!({ title: 'title2', img_url: 'url2', artist_id: u1.id })
a3 = Artwork.create!({ title: 'title3', img_url: 'url3', artist_id: u1.id })
a4 = Artwork.create!({ title: 'title1', img_url: 'url4', artist_id: u2.id })
a5 = Artwork.create!({ title: 'title1', img_url: 'url5', artist_id: u3.id })
a6 = Artwork.create!({ title: 'title2', img_url: 'url6', artist_id: u3.id })
a7 = Artwork.create!({ title: 'title3', img_url: 'url7', artist_id: u3.id })
a8 = Artwork.create!({ title: 'title4', img_url: 'url8', artist_id: u3.id })
a9 = Artwork.create!({ title: 'title1', img_url: 'url9', artist_id: u4.id })

s1  = ArtworkShare.create!({ artwork_id: a4.id, viewer_id: u1.id })
s2  = ArtworkShare.create!({ artwork_id: a4.id, viewer_id: u3.id })
s3  = ArtworkShare.create!({ artwork_id: a4.id, viewer_id: u4.id })
s4  = ArtworkShare.create!({ artwork_id: a4.id, viewer_id: u5.id })
s5  = ArtworkShare.create!({ artwork_id: a1.id, viewer_id: u2.id })
s6  = ArtworkShare.create!({ artwork_id: a1.id, viewer_id: u3.id })
s7  = ArtworkShare.create!({ artwork_id: a1.id, viewer_id: u4.id })
s8  = ArtworkShare.create!({ artwork_id: a2.id, viewer_id: u3.id })
s9  = ArtworkShare.create!({ artwork_id: a5.id, viewer_id: u1.id })
s10 = ArtworkShare.create!({ artwork_id: a5.id, viewer_id: u5.id })
s11 = ArtworkShare.create!({ artwork_id: a6.id, viewer_id: u1.id })
s12 = ArtworkShare.create!({ artwork_id: a7.id, viewer_id: u4.id })
s13 = ArtworkShare.create!({ artwork_id: a7.id, viewer_id: u5.id })
s14 = ArtworkShare.create!({ artwork_id: a9.id, viewer_id: u1.id })
s15 = ArtworkShare.create!({ artwork_id: a9.id, viewer_id: u2.id })

c1 = Comment.create!({ artwork_id: a4.id, user_id: u1.id, body: "Cool!"})
c2 = Comment.create!({ artwork_id: a4.id, user_id: u3.id, body: "True Masterpiece!"})
c3 = Comment.create!({ artwork_id: a6.id, user_id: u2.id, body: "Nice User3!"})
c4 = Comment.create!({ artwork_id: a9.id, user_id: u2.id, body: "Amazing!"})

co1 = Collection.create!({ user_id: u5.id, name: "user3 arts" })
co2 = Collection.create!({ user_id: u2.id, name: "bedroom deco options" })

ac1 = ArtworkCollection.create!({ collection_id: co1.id, artwork_id: a5.id })
ac2 = ArtworkCollection.create!({ collection_id: co1.id, artwork_id: a6.id })
ac3 = ArtworkCollection.create!({ collection_id: co1.id, artwork_id: a7.id })
ac4 = ArtworkCollection.create!({ collection_id: co1.id, artwork_id: a8.id })

ac5 = ArtworkCollection.create!({ collection_id: co2.id, artwork_id: a3.id })
ac6 = ArtworkCollection.create!({ collection_id: co2.id, artwork_id: a5.id })
ac7 = ArtworkCollection.create!({ collection_id: co2.id, artwork_id: a9.id })