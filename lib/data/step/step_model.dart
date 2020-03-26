import './step_entity.dart';

class Step {
  Step({this.order, this.text, this.completed});

  String text;
  int order;
  bool completed;

  Step copyWith({int order, String text, bool completed}) {
    return Step(
      text: text ?? this.text,
      order: order ?? this.order,
      completed: completed ?? this.completed,
    );
  }

  StepEntity toEntity() {
    return StepEntity(text: text, order: order, completed: completed);
  }

  static Step fromEntity(StepEntity entity) {
    return Step(
      text: entity.text,
      completed: entity.completed,
      order: entity.order,
    );
  }
}
