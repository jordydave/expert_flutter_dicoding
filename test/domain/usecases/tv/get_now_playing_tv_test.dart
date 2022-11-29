import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_now_playing_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingTV usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetNowPlayingTV(mockTVRepository);
  });

  final tTVs = <TV>[];

  test('should get list of tv from the repository', () async {
    // arrange
    when(mockTVRepository.getNowPlayingTV())
        .thenAnswer((_) async => Right(tTVs));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTVs));
  });
}
