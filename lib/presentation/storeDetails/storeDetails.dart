import 'package:flutter/material.dart';
import 'package:mvvm_first_c/app/di.dart';
import 'package:mvvm_first_c/data/mapper/mapper.dart';
import 'package:mvvm_first_c/domain/model.dart';
import 'package:mvvm_first_c/presentation/resources/strings_manager.dart';
import 'package:mvvm_first_c/presentation/resources/values_manager.dart';
import 'package:mvvm_first_c/presentation/state_renderer/state_renderer_implimenter.dart';
import 'package:mvvm_first_c/presentation/storeDetails/store_details_viewmodel.dart';

import '../resources/color_manager.dart';

class StoreDetailsView extends StatefulWidget {
  const StoreDetailsView({Key? key}) : super(key: key);

  @override
  _StoreDetailsViewState createState() => _StoreDetailsViewState();
}

class _StoreDetailsViewState extends State<StoreDetailsView> {
  StoreDetailsViewModel _viewModel = instance<StoreDetailsViewModel>();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() {
    _viewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
                  context,
                  StreamBuilder<StoreDetail>(
                      stream: _viewModel.outputStores,
                      builder: (context, snapshot) {
                        return Scaffold(
                          appBar: AppBar(
                            title: Text(snapshot.data?.title ?? EMPTY),
                          ),
                          body: _getContentWidget(context, snapshot.data),
                        );
                      }), () {
                _viewModel.start();
              }) ??
              Container();
        });
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  Widget _getContentWidget(BuildContext context, StoreDetail? storeDetail) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getStoreImageWidget(storeDetail?.image),
          Padding(
            padding: const EdgeInsets.only(
              left: AppPadding.p16,
              right: AppPadding.p16,
            ),
            child: Text(AppStrings.detail,
                style: Theme.of(context).textTheme.headline3),
          ),
          _getStoreDetailWidget(storeDetail?.detail),
          Padding(
              padding: const EdgeInsets.only(
                left: AppPadding.p16,
                right: AppPadding.p16,
              ),
              child: Text(AppStrings.services,
                  style: Theme.of(context).textTheme.headline3)),
          _getStoreServicesWidget(storeDetail?.services),
          Padding(
            padding: const EdgeInsets.only(
              left: AppPadding.p16,
              right: AppPadding.p16,
            ),
            child: Text(AppStrings.aboutStore,
                style: Theme.of(context).textTheme.headline3),
          ),
          _getStoreAboutWidget(storeDetail?.about)
        ],
      ),
    );
  }

  Widget _getStoreImageWidget(String? detail) {
    if (detail != null) {
      return Padding(
        padding: const EdgeInsets.only(
            left: AppPadding.p8,
            right: AppPadding.p8,
            top: AppPadding.p8,
            bottom: AppPadding.p16),
        child: SizedBox(
          width: double.infinity,
          child: Card(
            elevation: AppSize.s1_5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12),
                side:
                    BorderSide(color: ColorManager.white, width: AppSize.s1_5)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s12),
              child: Image.network(
                detail,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getStoreDetailWidget(String? detail) {
    if (detail != null) {
      return Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Text(detail),
      );
    } else {
      return Container();
    }
  }

  Widget _getStoreServicesWidget(String? detail) {
    if (detail != null) {
      return Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Text(detail),
      );
    } else {
      return Container();
    }
  }

  Widget _getStoreAboutWidget(String? detail) {
    if (detail != null) {
      return Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Text(detail),
      );
    } else {
      return Container();
    }
  }
}
