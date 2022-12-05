import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_similar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTVSimilar usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetTVSimilar(mockTVRepository);
  });

  const tId = 1;
  final tTVs = <TV>[];

  test('should get list of tv similar from the repository', () async {
    // arrange
    when(mockTVRepository.getTVSimilar(tId))
        .thenAnswer((_) async => Right(tTVs));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tTVs));
  });
}
