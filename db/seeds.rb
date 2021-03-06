activityTypes = ActivityType.create(
		[
				{name: 'Sulkapallo', style: "background-image: url('http://www.brasil2016.gov.br/sites/default/files/editada_-_shutterstock_106009616.jpg'); "},
				{name: 'Tennis', style: "background-image: url('http://www.kenwoodtravel.co.uk/gallery/Tennis-Court-at-Sandy-Lane-Barbados__00.jpg'); "},
				{name: 'Juoksu', style: "background-image: url('https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTDfvmK6FwTWQJOdkwnQKrKiAAXsviZchKTao-AqoFEti0pST0oKA'); "},
				{name: 'Jalkapallo', style: "background-image: url('https://drhurd.com/wp-content/uploads/2014/08/soccer400.png'); "},
				{name: 'Hiihto', style: "background-image: url('http://www.binggl.com/tl_files/images/contentBilder/WINTER/langlaufen/15_vision_perform_classic_07_08_low.jpg');"},
				{name: 'Pingis', style: "background-image: url('http://www.askaboutsports.com/images/table-tennis/table-tennis-net-ball-racquets-bsp-6906947-500x333.jpg');"},
				{name: 'Uinti', style: "background-image: url('http://www.edinburghleisure.co.uk/sites/default/files/styles/hero_large/public/EL_0006_Dalry%20swim%20centre_0.jpg?itok=u9Z1bs0Q');"}
		]
)

roope = User.create({email: 'roope.hakulinen@gmail.com', password: 'password', authentication_token: 'abcdefghijklmopqrstuvwxyz', profile_attributes: {
		name: 'Roope Hakulinen',
		picture: 'https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xfp1/v/t1.0-1/c0.0.160.160/p160x160/1375143_10152566661584237_216203503_n.jpg?oh=6ca6ce1f9c037575b02e7825a322f5ab&oe=55FB0B9E&__gda__=1445962610_1bece924c3b6c43a895fe8b1b5099329',
		description: 'Minä vain', born: 23.years.ago, rating_mean: 4.9, rating_count: 100000}})

jesse = User.create({email: 'jesse.kaislavuo@gmail.com', password: 'password', authentication_token: 'abcdefghijklmopqrstuvwxy', profile_attributes: {
		name: 'Jesse Kaislavuo',
		picture: 'https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xpt1/v/t1.0-1/p160x160/7106_10205157218956076_6880177833201530544_n.jpg?oh=f3267a0aa8f3d58f4ebb1beda2ffc4cf&oe=55F47A13&__gda__=1442890571_6d23b17ec0445c8088eedb0c57974f33',
		description: 'Jepu', born: 23.years.ago, rating_mean: 4.5, rating_count: 9999}})

Direct.create!({user: roope, direct: jesse})

activity1 = Activity.create(organizer: roope,
                            from: Time.now + 1.week, to: Time.now + 1.week + 1.hour,
                            activity_type: activityTypes[0],
                            location_name: 'Keskustori', lat: 61.498172, lng: 23.761092,
                            participant_count: 4, required_level: 3.0)
activity2 = Activity.create(organizer: roope,
                            from: Time.now + 2.weeks, to: Time.now + 2.weeks + 4.hours,
                            activity_type: activityTypes[1],
                            location_name: 'Pispalan portaat', lat: 61.499172, lng: 23.761092,
                            participant_count: 2, required_level: 5.0)
activity3 = Activity.create(organizer: jesse,
                            from: Time.now + 2.weeks + 4.days, to: Time.now + 2.weeks + 4.days + 5.hours,
                            activity_type: activityTypes[2],
                            location_name: 'Koiviston koulu', lat: 61.498172, lng: 23.755092,
                            participant_count: 6,
                            required_level: 3.0)
activity4 = Activity.create(organizer: jesse,
                            from: Time.now + 2.weeks + 4.days, to: Time.now + 2.weeks + 4.days + 5.hours,
                            activity_type: activityTypes[5],
                            location_name: 'Koiviston koulu', lat: 61.498172, lng: 23.755092,
                            participant_count: 2, required_level: 4.0)
activity5 = Activity.create(organizer: jesse,
                            from: Time.now + 2.weeks + 4.days, to: Time.now + 2.weeks + 4.days + 5.hours,
                            activity_type: activityTypes[6], location_name: 'Koiviston koulu', lat: 61.498172, lng: 23.755092,
                            participant_count: 2,
                            required_level: 1.0)

user2 = User.create({email: 'user2@example.com', password: 'password', authentication_token: 'abcdefghijklmopqrstuvwxyz2', profile_attributes: {
		name: 'Example User 2', description: 'Just another example user', born: 20.years.ago, rating_mean: 4.0, rating_count: 10}})

user3 = User.create({email: 'user3@example.com', password: 'password', authentication_token: 'abcdefghijklmopqrstuvwxyz3', profile_attributes: {
		name: 'Example User 3', description: 'Just another example user', born: 20.years.ago, rating_mean: 4.0, rating_count: 10}})

user4 = User.create({email: 'user4@example.com', password: 'password', authentication_token: 'abcdefghijklmopqrstuvwxyz4', profile_attributes: {
		name: 'Example User 4', description: 'Just another example user', born: 15.years.ago, rating_mean: 0.5, rating_count: 10000}})

user5 = User.create({email: 'user5@example.com', password: 'password', authentication_token: 'abcdefghijklmopqrstuvwxyz5', profile_attributes: {
		name: 'Example User 5', description: 'Just another example user', born: 35.years.ago, rating_mean: 1.0, rating_count: 3}})

user6 = User.create({email: 'user6@example.com', password: 'password', authentication_token: 'abcdefghijklmopqrstuvwxyz6', profile_attributes: {
		name: 'Example User 6', description: 'Just another example user', born: 24.years.ago, rating_mean: 2.0, rating_count: 20}})

Suggestion.create(activity: activity1, user: jesse, status: :match)
Suggestion.create(activity: activity2, user: jesse, status: :invited)

Suggestion.create(activity: activity1, user: user2, status: :match)
Suggestion.create(activity: activity1, user: user3, status: :match)
Suggestion.create(activity: activity1, user: user4, status: :invited)

Suggestion.create(activity: activity2, user: user2, status: :invited)
Suggestion.create(activity: activity2, user: user3, status: :invited)
Suggestion.create(activity: activity2, user: user4, status: :invited)
Suggestion.create(activity: activity2, user: user5, status: :invited)
Suggestion.create(activity: activity2, user: user6, status: :invited)

Suggestion.create(activity: activity4, user: roope, status: :match)
Suggestion.create(activity: activity5, user: roope, status: :invited)
