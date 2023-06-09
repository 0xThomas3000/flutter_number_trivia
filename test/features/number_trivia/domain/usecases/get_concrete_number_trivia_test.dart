import 'package:flutter_number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_number_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'get_concrete_number_trivia_test.mocks.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

@GenerateMocks([MockNumberTriviaRepository])
void main() {
  late final GetConcreteNumberTrivia usecase;
  late final MockMockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockMockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  const tNumber = 1;
  const tNumberTrivia = NumberTrivia(text: 'Test', number: 1);

  group(
    'Successful tests:',
    () {
      test(
        'Should get trivia for the number from the repository',
        () async {
          // Arrange
          when(mockNumberTriviaRepository.getConcreteNumberTrivia(any))
              .thenAnswer((_) async => const Right(tNumberTrivia));

          // Act
          final result = await usecase.execute(number: tNumber);

          // Assert
          verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
          verifyNoMoreInteractions(mockNumberTriviaRepository);
          expect(result, const Right(tNumberTrivia));
        },
      );
    },
  );
}
