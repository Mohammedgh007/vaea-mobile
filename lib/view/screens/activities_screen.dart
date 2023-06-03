import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../bloc/providers/activities_provider.dart';
import '../widgets/navigation/adaptive_top_app_bar.dart';
import '../widgets/navigation/bottom_navigation.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

/// This class handles the view and its interactions with the rest of app
/// for activities screen.
class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  List<Appointment> getRecurringAppointments() {
    final List<Appointment> appointments = [];

    final startDate = DateTime(2023, 6, 3);
    final endDate = DateTime(2023, 7, 15);

    for (DateTime date = startDate;
        date.isBefore(endDate);
        date = date.add(const Duration(days: 7))) {
      final appointment = Appointment(
        startTime: date,
        endTime: date.add(const Duration(hours: 1)),
        subject: 'Recurring Event',
        isAllDay: false,
        recurrenceRule: 'FREQ=WEEKLY;BYDAY=MO',
      );

      appointments.add(appointment);
    }

    return appointments;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ActivitiesProvider>(
      builder: (context, provider, child) => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          Breakpoint breakpoint = Breakpoint.fromConstraints(constraints);
          return Scaffold(
            appBar: AdaptiveTopAppBar(
              breakpoint: breakpoint,
              layoutConstraints: constraints,
              currPageTitle: AppLocalizations.of(context)!.activities,
            ),
            body: SfCalendar(
              view: CalendarView.month,
              dataSource: EventDataSource(provider.appointments),

              onViewChanged: (viewChangedDetails) {
                DateTime currentMonth = viewChangedDetails.visibleDates[0];
                provider.loadMonthEvents(currentMonth.month.toString());
              },

              appointmentBuilder:
                  (BuildContext context, CalendarAppointmentDetails details) {
                final Event event = details.appointments.first as Event;
                return Container(
                  // width: details.bounds.width,
                  // height: details.bounds.height,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Center(
                    child: Text(
                      '${event.eventName}, Going people: ${event.goingPeople}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },

              monthViewSettings: const MonthViewSettings(
                navigationDirection: MonthNavigationDirection.vertical,
                showAgenda: true,
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                showTrailingAndLeadingDates: false,
              ),
              // dataSource: AppointmentDataSource(recurringAppointments),
            ),
            bottomNavigationBar: BottomNavigation(currentIndex: 1),
          );
        },
      ),
    );
  }
}
