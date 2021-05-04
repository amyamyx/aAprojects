# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u1 = User.create!({ username: 'apollo3' })
u2 = User.create!({ username: 'avatar_rox' })
u3 = User.create!({ username: 'muskxnasa' })

p1 = Poll.create!({ user_id: u1.id, title: 'Product Satisfation'})
p2 = Poll.create!({ user_id: u3.id, title: 'Store Experience'})

q1 = Question.create!({ poll_id: p1.id, text: 'Please rate the material quality'})
q2 = Question.create!({ poll_id: p1.id, text: 'Please rate the product\'s fitting'})

q3 = Question.create!({ poll_id: p2.id, text: 'Did someone greet you when you enetered the store?'})
q4 = Question.create!({ poll_id: p2.id, text: 'Please rate the easiness of finding the products you need'})
q5 = Question.create!({ poll_id: p2.id, text: 'Please rate the customer service you recieved'})

ac1 = AnswerChoice.create!({ question_id: q1.id, text:'1 highly unsatisfied' })
ac2 = AnswerChoice.create!({ question_id: q1.id, text:'2' })
ac3 = AnswerChoice.create!({ question_id: q1.id, text:'3' })
ac4 = AnswerChoice.create!({ question_id: q1.id, text:'4' })
ac5 = AnswerChoice.create!({ question_id: q1.id, text:'5 Extremely satisfied' })

ac6 = AnswerChoice.create!({ question_id: q2.id, text:'far too tight' })
ac7 = AnswerChoice.create!({ question_id: q2.id, text:'slightly too tight' })
ac8 = AnswerChoice.create!({ question_id: q2.id, text:'true to size' })
ac9 = AnswerChoice.create!({ question_id: q2.id, text:'slightly too loose' })
ac10 = AnswerChoice.create!({ question_id: q2.id, text:'far too loose' })

ac11 = AnswerChoice.create!({ question_id: q3.id, text:'Yes' })
ac12 = AnswerChoice.create!({ question_id: q3.id, text:'No' })
ac13 = AnswerChoice.create!({ question_id: q3.id, text:'Not sure' })

ac14 = AnswerChoice.create!({ question_id: q4.id, text:'1 Extremely hard to find' })
ac15 = AnswerChoice.create!({ question_id: q4.id, text:'2' })
ac16 = AnswerChoice.create!({ question_id: q4.id, text:'3' })
ac17 = AnswerChoice.create!({ question_id: q4.id, text:'4' })
ac18 = AnswerChoice.create!({ question_id: q4.id, text:'5 Extremely easy to find' })

ac19 = AnswerChoice.create!({ question_id: q5.id, text:'1 highly unsatisfied' })
ac20 = AnswerChoice.create!({ question_id: q5.id, text:'2' })
ac21 = AnswerChoice.create!({ question_id: q5.id, text:'3' })
ac22 = AnswerChoice.create!({ question_id: q5.id, text:'4' })
ac23 = AnswerChoice.create!({ question_id: q5.id, text:'5 Extremely satisfied' })

r1 = Response.create!({ user_id: u3.id, answer_choice_id: ac3.id })
r2 = Response.create!({ user_id: u3.id, answer_choice_id: ac10.id})

r3 = Response.create!({ user_id: u2.id, answer_choice_id: ac13.id})