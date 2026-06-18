// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'Core/api/api_consumer.dart' as _i989;
import 'Core/api/dio_consumer.dart' as _i425;
import 'Core/api/logging_interceptor.dart' as _i777;
import 'Core/error/error_interceptor.dart' as _i731;
import 'Core/Network/network_info.dart' as _i1071;
import 'Core/third_party_injection.dart' as _i540;
import 'Core/utils/shared_preference_utils.dart' as _i131;
import 'Features/Auth/login/cubit/login_cubit.dart' as _i323;
import 'Features/Auth/login/cubit/login_password_visibility_cubit.dart' as _i72;
import 'Features/Auth/login/Data/Repostry/basereposotry_login.dart' as _i848;
import 'Features/Auth/login/Data/Repostry/login_reposotry.dart' as _i983;
import 'Features/Auth/login/Data/Web%20Service/login_webservice.dart' as _i786;
import 'Features/User/detailes_transactions_page/cubit/detailes_transactions_page_cubit.dart'
    as _i608;
import 'Features/User/detailes_transactions_page/Data/Repostry/basereposotry_detailes_transactions_page.dart'
    as _i191;
import 'Features/User/detailes_transactions_page/Data/Repostry/detailes_transactions_page_reposotry.dart'
    as _i69;
import 'Features/User/detailes_transactions_page/Data/Web%20Service/detailes_transactions_page_webservice.dart'
    as _i856;
import 'Features/User/detailes_transactions_page/manager/add_repliy/cubit/add_repliy_cubit.dart'
    as _i1031;
import 'Features/User/detailes_transactions_page/manager/add_repliy/Data/Repostry/add_repliy_reposotry.dart'
    as _i770;
import 'Features/User/detailes_transactions_page/manager/add_repliy/Data/Repostry/basereposotry_add_repliy.dart'
    as _i462;
import 'Features/User/detailes_transactions_page/manager/add_repliy/Data/Web%20Service/add_repliy_webservice.dart'
    as _i765;
import 'Features/User/detailes_transactions_page/manager/change_status/cubit/change_status_cubit.dart'
    as _i923;
import 'Features/User/detailes_transactions_page/manager/change_status/Data/Repostry/basereposotry_change_status.dart'
    as _i429;
import 'Features/User/detailes_transactions_page/manager/change_status/Data/Repostry/change_status_reposotry.dart'
    as _i410;
import 'Features/User/detailes_transactions_page/manager/change_status/Data/Web%20Service/change_status_webservice.dart'
    as _i569;
import 'Features/User/notification_page/cubit/notification_cubit.dart' as _i912;
import 'Features/User/notification_page/Data/Repostry/basereposotry_notification.dart'
    as _i101;
import 'Features/User/notification_page/Data/Repostry/notification_reposotry.dart'
    as _i95;
import 'Features/User/notification_page/Data/Web%20Service/notification_webservice.dart'
    as _i927;
import 'Features/User/transactions_page/cubit/transactions_page_cubit.dart'
    as _i146;
import 'Features/User/transactions_page/Data/Repostry/basereposotry_transactions_page.dart'
    as _i1038;
import 'Features/User/transactions_page/Data/Repostry/transactions_page_reposotry.dart'
    as _i638;
import 'Features/User/transactions_page/Data/Web%20Service/transactions_page_webservice.dart'
    as _i139;
import 'Features/User/transactions_page/manager/logout/cubit/logout_cubit.dart'
    as _i413;
import 'Features/User/transactions_page/manager/logout/Data/Repostry/basereposotry_logout.dart'
    as _i477;
import 'Features/User/transactions_page/manager/logout/Data/Repostry/logout_reposotry.dart'
    as _i32;
import 'Features/User/transactions_page/manager/logout/Data/Web%20Service/logout_webservice.dart'
    as _i588;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final thirdPartyInjection = _$ThirdPartyInjection();
    gh.factory<_i72.LoginPasswordVisibilityCubit>(
      () => _i72.LoginPasswordVisibilityCubit(),
    );
    gh.singleton<_i777.LoggingInterceptor>(() => _i777.LoggingInterceptor());
    gh.singleton<_i731.ErrorInterceptor>(() => _i731.ErrorInterceptor());
    gh.singleton<_i361.Dio>(() => thirdPartyInjection.dio);
    gh.singleton<_i895.Connectivity>(() => thirdPartyInjection.connectivity);
    gh.singleton<_i131.SharedPreferencesUtils>(
      () => thirdPartyInjection.sharedPreferencesUtils,
    );
    gh.singleton<_i989.ApiConsumer>(() => _i425.DioConsumer(gh<_i361.Dio>()));
    gh.singleton<_i139.TransactionsPageWebService>(
      () => _i139.TransactionsPageWebServiceImpl(gh<_i989.ApiConsumer>()),
    );
    gh.singleton<_i856.DetailesTransactionsPageWebService>(
      () =>
          _i856.DetailesTransactionsPageWebServiceImpl(gh<_i989.ApiConsumer>()),
    );
    gh.singleton<_i927.NotificationWebService>(
      () => _i927.NotificationWebServiceImpl(gh<_i989.ApiConsumer>()),
    );
    gh.lazySingleton<_i1071.NetworkInfo>(
      () => _i1071.NetworkInfoImpl(connectivity: gh<_i895.Connectivity>()),
    );
    gh.singleton<_i588.LogOutWebService>(
      () => _i588.LogOutWebServiceImpl(gh<_i989.ApiConsumer>()),
    );
    gh.singleton<_i786.LoginWebService>(
      () => _i786.LoginWebServiceImpl(gh<_i989.ApiConsumer>()),
    );
    gh.singleton<_i191.BaseReposotrydetailesTransactionsPage>(
      () => _i69.DetailesTransactionsPageReposotryImpl(
        networkInfo: gh<_i1071.NetworkInfo>(),
        detailesTransactionsPageWebService:
            gh<_i856.DetailesTransactionsPageWebService>(),
      ),
    );
    gh.singleton<_i477.BaseReposotrylogOut>(
      () => _i32.LogOutReposotryImpl(
        networkInfo: gh<_i1071.NetworkInfo>(),
        logOutWebService: gh<_i588.LogOutWebService>(),
      ),
    );
    gh.factory<_i608.DetailesTransactionsPageCubit>(
      () => _i608.DetailesTransactionsPageCubit(
        gh<_i191.BaseReposotrydetailesTransactionsPage>(),
      ),
    );
    gh.singleton<_i101.BaseReposotrynotification>(
      () => _i95.NotificationReposotryImpl(
        networkInfo: gh<_i1071.NetworkInfo>(),
        notificationWebService: gh<_i927.NotificationWebService>(),
      ),
    );
    gh.singleton<_i848.BaseReposotryLogin>(
      () => _i983.LoginReposotryImpl(
        networkInfo: gh<_i1071.NetworkInfo>(),
        loginWebService: gh<_i786.LoginWebService>(),
      ),
    );
    gh.singleton<_i765.AddRepliyWebService>(
      () => _i765.AddRepliyWebServiceImpl(gh<_i989.ApiConsumer>()),
    );
    gh.singleton<_i569.ChangeStatusWebService>(
      () => _i569.ChangeStatusWebServiceImpl(gh<_i989.ApiConsumer>()),
    );
    gh.singleton<_i1038.BaseReposotrytransactionsPage>(
      () => _i638.TransactionsPageReposotryImpl(
        networkInfo: gh<_i1071.NetworkInfo>(),
        transactionsPageWebService: gh<_i139.TransactionsPageWebService>(),
      ),
    );
    gh.factory<_i413.LogOutCubit>(
      () => _i413.LogOutCubit(gh<_i477.BaseReposotrylogOut>()),
    );
    gh.singleton<_i429.BaseReposotrychangeStatus>(
      () => _i410.ChangeStatusReposotryImpl(
        networkInfo: gh<_i1071.NetworkInfo>(),
        changeStatusWebService: gh<_i569.ChangeStatusWebService>(),
      ),
    );
    gh.factory<_i912.NotificationCubit>(
      () => _i912.NotificationCubit(gh<_i101.BaseReposotrynotification>()),
    );
    gh.factory<_i146.TransactionsPageCubit>(
      () => _i146.TransactionsPageCubit(
        gh<_i1038.BaseReposotrytransactionsPage>(),
      ),
    );
    gh.factory<_i323.LoginCubit>(
      () => _i323.LoginCubit(
        gh<_i848.BaseReposotryLogin>(),
        gh<_i131.SharedPreferencesUtils>(),
      ),
    );
    gh.singleton<_i462.BaseReposotryaddRepliy>(
      () => _i770.AddRepliyReposotryImpl(
        networkInfo: gh<_i1071.NetworkInfo>(),
        addRepliyWebService: gh<_i765.AddRepliyWebService>(),
      ),
    );
    gh.factory<_i1031.AddRepliyCubit>(
      () => _i1031.AddRepliyCubit(gh<_i462.BaseReposotryaddRepliy>()),
    );
    gh.factory<_i923.ChangeStatusCubit>(
      () => _i923.ChangeStatusCubit(gh<_i429.BaseReposotrychangeStatus>()),
    );
    return this;
  }
}

class _$ThirdPartyInjection extends _i540.ThirdPartyInjection {}
