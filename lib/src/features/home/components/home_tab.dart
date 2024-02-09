import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shahzaib_abid/src/constants/asset_string.dart';
import 'package:shahzaib_abid/src/features/home/cubit/home_cubit.dart';
import 'package:shahzaib_abid/src/features/home/models/home_model.dart';

import '../../../constants/colors.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  CategoryData? selectedCategory;
  SubCategory? selectedSubCategory;
  
  @override
  void initState() {
    super.initState();
    final bloc = BlocProvider.of<HomeCubit>(context);
    bloc.getHomeData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Container(
          width: 35, height: 35,
          padding: const EdgeInsets.all(7),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8)
          ),
          child: SvgPicture.asset(AssetString.menu),
        ),
        title: SvgPicture.asset(AssetString.logo1, height: 30,),
        actions: [
          Container(
            width: 35, height: 35,
            padding: const EdgeInsets.all(7),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8)
            ),
            child: SvgPicture.asset(AssetString.search),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: Divider(color: Colors.grey.shade200, height: 1,),
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        // buildWhen: (c, p)=> c is HomeDataLoaded,
        builder: (context, state) {

          if(state is HomeDataLoading && state.loading){
            return const Center(child: CircularProgressIndicator.adaptive(),);
          }

          if(state is HomeDataError){
            return Center(child: Text(state.message));
          }

          if(state is HomeDataLoaded) {
            if(selectedCategory == null){
              selectedCategory = state.categories?[0];
              selectedSubCategory = selectedCategory?.subCategory[0];
            }

            return Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 60,
                  padding: const EdgeInsets.all(15),
                  child: ListView.separated(
                    itemCount: state.categories?.length ?? 0,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      final item = state.categories?[index];
                      return GestureDetector(
                        onTap: (){
                          print('---');
                          setState(() {
                            selectedCategory = item;
                            selectedSubCategory = selectedCategory?.subCategory[0];
                          });
                        },
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: selectedCategory == item ? MyColors.primaryColor : Colors.grey.shade200, )
                              ),
                              child: Text(item?.name ?? '', style: TextStyle(
                                  color: selectedCategory == item ? Colors.black : Colors.grey),),
                            ),
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(color: selectedCategory == item ? MyColors.primaryColor : Colors.grey)
                              ),
                              child: Text(selectedCategory?.subCategory.length.toString() ?? 0.toString(),
                                style: TextStyle(color:  selectedCategory == item ? MyColors.primaryColor : Colors.grey),),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index){
                      return const SizedBox(width: 10,);
                    },
                  ),
                ),
                Divider(color: Colors.grey.shade200, height: 1,),
                const SizedBox(height: 15,),
                Container(
                  height: 70,
                  margin: const EdgeInsets.only(left: 15),
                  child: ListView.separated(
                    itemCount: selectedCategory?.subCategory.length ?? 0,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      final item = selectedCategory?.subCategory[index];
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            selectedSubCategory = item;
                          });
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: selectedSubCategory == item
                                        ? MyColors.primaryColor
                                        : Colors.grey.shade300,
                                    width: 1.5),
                                shape: BoxShape.circle,
                              ),
                              child: Container(
                                margin: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.network(item?.image ?? '', fit: BoxFit.cover,),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(color: selectedSubCategory == item ? MyColors.primaryColor : Colors.grey)
                              ),
                              child: Text(selectedSubCategory?.products.length.toString() ?? 0.toString(),
                                style: TextStyle(color:  selectedSubCategory == item ? MyColors.primaryColor : Colors.grey),),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index){
                      return const SizedBox(width: 7,);
                    },
                  ),
                ),
                const SizedBox(height: 15,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Text('Products', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
                      Spacer(),
                      Text('View All', style: TextStyle(color: MyColors.primaryColor, fontSize: 12),),
                      Icon(Icons.keyboard_arrow_right_sharp,)
                    ],
                  ),
                ),
                const SizedBox(height: 15,),
                Container(
                  height: 270, width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListView.separated(
                    itemCount: selectedSubCategory?.products.length ?? 0,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      final item = selectedSubCategory?.products[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 200, width: 180,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: NetworkImage(item?.image ?? ''),
                                    fit: BoxFit.cover
                                  )
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: Colors.green
                                ),
                                child: Text('-${item?.discountPercentage.toString() ?? ''}%',
                                  style: const TextStyle(color: Colors.white, fontSize: 12),),
                              )
                            ],
                          ),
                          const SizedBox(height: 8,),
                          Text(item?.name ?? '', style: const TextStyle(color: Colors.grey),),
                          Row(
                            children: [
                              Text('\$${item?.price ?? ''}', style: const TextStyle(color: Colors.grey, decoration: TextDecoration.lineThrough, decorationColor: Colors.grey),),
                              const SizedBox(width: 10,),
                              Text('\$${item?.discountedPrice() ?? ''}', style: const TextStyle(color: MyColors.primaryColor),),
                            ],
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index){
                      return const SizedBox(width: 10,);
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade400,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white
                          ),
                          child: Image.asset(AssetString.deliveryPng)),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Free Shipping Over \$0', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),),
                          SizedBox(height: 3,),
                          Text('Free returns and exchange', style: TextStyle(color: Colors.white, fontSize: 13),),
                        ],
                      ),
                      CircleAvatar(
                        backgroundColor: MyColors.primaryColor,
                        child: SvgPicture.asset(AssetString.phone),
                      )
                    ],
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
