Meteor.app.packages.register
  name: "reaction-hero"
  depends: [] #reaction packages
  label: "Hero Manager"
  description: "Reaction Hero Manager"
  icon: "fa fa-picture-o"
  settingsRoute: "dashboard/settings/hero"
  overviewRoute: "hero"
  template: "hero"
  hasWidget: true
  priority: "2"
  shopPermissions: [
    {
      label: "Hero"
      permission: "/hero"
      group: "Hero"
    }
  ]
