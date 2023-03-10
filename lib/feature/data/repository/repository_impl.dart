import 'dart:io';

import 'package:book_app/core/exception/exception.dart';
import 'package:book_app/core/exception/failure.dart';
import 'package:book_app/feature/data/data_source/remote_data_source.dart';
import 'package:book_app/feature/domain/entities/entities.dart';
import 'package:book_app/feature/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';


class RepositoryImpl extends Repository{
  final RemoteDataSource baseBookRemoteDataSource;

  RepositoryImpl(this.baseBookRemoteDataSource);

  @override
  Future<Either<Failure, Books>> getActions() async{
    try{
      final result = await baseBookRemoteDataSource.getActions();
      return Right(result);
    }on ServerException{
      return const Left(ServerFailure('Server Failure'));
    }on SocketException{
      return const Left(ConnectionFailure('Connection Failure'));
    }
  }

  @override
  Future<Either<Failure, Items>> getDetails(String id) async{
    try{
      final result = await baseBookRemoteDataSource.getDetails(id);
      return Right(result);
    }on ServerException{
      return const Left(ServerFailure('Server Failure'));
    }on SocketException{
      return const Left(ConnectionFailure('Connection Failure'));
    }
  }

  @override
  Future<Either<Failure, Books>> getFictions() async{
    try{
      final result = await baseBookRemoteDataSource.getFictions();
      return Right(result);
    }on ServerException{
      return const Left(ServerFailure('Server Failure'));
    }on SocketException{
      return const Left(ConnectionFailure('Connection Failure'));
    }
  }

  @override
  Future<Either<Failure, Books>> getHorrors() async{
    try{
      final result = await baseBookRemoteDataSource.getHorrors();
      return Right(result);
    }on ServerException{
      return const Left(ServerFailure('Server Failure'));
    }on SocketException{
      return const Left(ConnectionFailure('Connection Failure'));
    }
  }

  @override
  Future<Either<Failure, Books>> getNovels() async{
    try{
      final result = await baseBookRemoteDataSource.getNovels();
      return Right(result);
    }on ServerException{
      return const Left(ServerFailure('Server Failure'));
    }on SocketException{
      return const Left(ConnectionFailure('Connection Failure'));
    }
  }

  @override
  Future<void> login(String email, String password) {
    return baseBookRemoteDataSource.login(email, password);
  }

  @override
  Future<void> logout() {
    return baseBookRemoteDataSource.logout();
  }

  @override
  Future<void> register(String email, String password) {
    return baseBookRemoteDataSource.register(email, password);
  }
}