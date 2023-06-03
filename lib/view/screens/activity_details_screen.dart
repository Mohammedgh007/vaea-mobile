import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vaea_mobile/view/style/colors.dart';
import '../../bloc/providers/activities_provider.dart';
import '../layouts/mobile/home_details_mobile_layout.dart';
import '../widgets/navigation/adaptive_top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ActivityDetailsScreen extends StatefulWidget {
  const ActivityDetailsScreen({
    super.key,
  });

  @override
  State<ActivityDetailsScreen> createState() => _ActivityDetailsScreenState();
}

class _ActivityDetailsScreenState extends State<ActivityDetailsScreen> {
  late Event event;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Event? args = ModalRoute.of(context)!.settings.arguments as Event?;
    if (args != null) {
      event = args;
    }
    Provider.of<ActivitiesProvider>(context, listen: false)
        .loadActivity(event.eventId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ActivitiesProvider>(
        builder: (context, provider, child) => LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              Breakpoint breakpoint = Breakpoint.fromConstraints(constraints);
              return Scaffold(
                backgroundColor: const Color(0xffFBFBFB),
                appBar: AdaptiveTopAppBar(
                  breakpoint: breakpoint,
                  layoutConstraints: constraints,
                  currPageTitle: AppLocalizations.of(context)!.activityDetails,
                ),
                body: provider.singleEventResponse != null
                    ? EventDetailsBody(
                        singleEvent: provider.singleEventResponse!.data)
                    : const SizedBox(),
              );
            }));
  }
}

class EventDetailsBody extends StatelessWidget {
  final SingleEvent singleEvent;

  const EventDetailsBody({
    super.key,
    required this.singleEvent,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        ImageCarousel(
          imageUrls: singleEvent.eventImagesUrls,
        ),
        SizedBox(
          height: 33.h,
        ),
        _DefultContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.eventDetails,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w700, fontFamily: 'Montserrat'),
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                singleEvent.eventName,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Montserrat'),
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                singleEvent.eventAbout,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w700, fontFamily: 'Montserrat'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 47.h,
        ),
        _DefultContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Organizer',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w700, fontFamily: 'Montserrat'),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.network(
                      singleEvent.groupImageUrl,
                      width: 94.w,
                      height: 120.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Group Name',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Montserrat'),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        singleEvent.groupName,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                color: AppColors.mediumEmphasisText,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Montserrat'),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 47.h,
        ),
        _DefultContainer(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Time and Location',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w700, fontFamily: 'Montserrat'),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                const Icon(Icons.calendar_month),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  getDateFormatted(singleEvent.startTime.toString()),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w700, fontFamily: 'Montserrat'),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                const Icon(Icons.watch_later_outlined),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  getDateFormattedTime(singleEvent.startTime.toString()),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w700, fontFamily: 'Montserrat'),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              singleEvent.location,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontFamily: 'Montserrat'),
            ),
            AppGoogleMapView(
              position: LatLng(singleEvent.lat, singleEvent.lon),
              imageSize: 400,
              mapViewHeight: 400,
            )
          ],
        )),
      ],
    ));
  }

  getDateFormatted(String date) {
    DateTime parsedDate = DateTime.parse(date); // Parse it to DateTime

    final DateFormat formatter = DateFormat('EEEE, MM/d');
    final String formatted = formatter.format(parsedDate);
    return formatted;
  }

  getDateFormattedTime(String date) {
    DateTime parsedDate = DateTime.parse(date); // Parse it to DateTime

    final DateFormat formatter = DateFormat('h:mm a');
    final String formatted = formatter.format(parsedDate);
    return formatted;
  }
}

class ImageCarousel extends StatelessWidget {
  final List<String> imageUrls;

  const ImageCarousel({Key? key, required this.imageUrls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: imageUrls.length,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return Image.network(imageUrls[index]);
      },
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: false,
      ),
    );
  }
}

class _DefultContainer extends StatelessWidget {
  final Widget child;
  const _DefultContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 356.w,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(18)),
        child: Padding(padding: const EdgeInsets.all(8.0), child: child));
  }
}
