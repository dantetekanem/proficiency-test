[
  { name: 'Leonardo', status: 'active' }, { name: 'Dante', status: 'active' }
].each { |student| Student.create(student) unless Student.exists?(name: student[:name]) }
[
  { name: 'Rails', status: 'active' }, { name: 'Meteor.js', status: 'active' }, { name: 'Ember.js', status: 'unactive' }
].each { |course| Course.create(course) unless Course.exists?(name: course[:name]) }
