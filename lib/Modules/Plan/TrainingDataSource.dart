// lib/features/plan/training_data_source.dart
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TrainingDataSource extends CalendarDataSource {
  TrainingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
