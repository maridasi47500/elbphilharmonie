# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Newsletter.destroy_all
Event.destroy_all
Newsletter.create(name_en: "Elbphilharmonie Newsletter (bimonthly in German)", description_en: "Latest concert announcements, festival news, special offers")
Newsletter.create(name_en: "School and Kindergarten Newsletter", description_en: "Newsletter for teachers and educators")
Newsletter.create(name_en: "Elbphilharmonie Newsletter in English (quarterly)", description_en: "Programme announcements and special offers quarterly in English")

e=Event.create(venue: Venue.all.sample, title: "concert de violon", subtitle: "Beethoven played by millie brady", image: "violinist.jpeg", price: "25", time: "20:30", date: "30-06-2022")

e.eventcats << Mycat.find_by_name_en("Genres").eventcats.sample(2)
e.eventcats << Mycat.find_by_name_en("Suitable for").eventcats.sample(5)
e.eventcats << Mycat.find_by_name_en("Type of event").eventcats.first(2)


e=Event.create(venue: Venue.all.sample, title: "concert d'alto", subtitle: "Bach played by millie brady", image: "altiste.jpeg", price: "30", time: "19:45", date: "22-07-2022")

e.eventcats << Mycat.find_by_name_en("Genres").eventcats.sample(2)
e.eventcats << Mycat.find_by_name_en("Suitable for").eventcats.sample(5)
e.eventcats << Mycat.find_by_name_en("Type of event").eventcats.first(2)
@venue=Venue.find_by(name_en: "Laeiszhalle Hamburg")
@venue2=Venue.create(name_en: "Großer Saal", url: "LHGS/")
@venue3=Venue.create(name_en: "Kleiner Saal", url: "LHKS/")

@venue2.surelements << @venue
@venue3.surelements << @venue
