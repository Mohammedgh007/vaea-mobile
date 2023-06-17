enum ServicesTypes {
  houseCleaning(
    title: 'House Cleaning',
    description:
        'Our home keep workers cleans home at scheduled time for your comfort ',
    image: 'assets/images/services/house_cleaning.png',
    supURL: 'submit-clean-house',
  ),
  plumbing(
    title: 'Plumbing',
    description:
        'Our trained plumbers can fix any plumbing related issue for free',
    image: 'assets/images/services/plumbing.png',
    supURL: 'submit-plumbing',
  ),
  electrician(
    title: 'Electrician',
    description: 'Our trained electricians can fix any related issue for free',
    image: 'assets/images/services/electrician.png',
    supURL: 'submit-electrician',
  ),
  acMaintenance(
    title: 'AC Maintenance',
    description:
        'Our trained ac technician can fix any related related issue for free',
    image: 'assets/images/services/AC_Maintenance.png',
    supURL: 'submit-clean-house',
  ),
  carWash(
    title: 'Car Wash',
    description: 'Let Sweater agent comes by to wash your car at its parking',
    image: 'assets/images/services/Car_Wash.png',
    supURL: 'submit-clean-house',
  ),
  carsOilChange(
    title: 'Car’s Oil Change',
    description:
        'Let Ezhalha agent comes by to do oil change for your parked car',
    image: 'assets/images/services/Car’s_Oil_Change.png',
    supURL: 'submit-clean-house',
  );

  const ServicesTypes(
      {required this.title,
      required this.description,
      required this.image,
      required this.supURL});

  final String title;
  final String description;
  final String image;
  final String supURL;
}
