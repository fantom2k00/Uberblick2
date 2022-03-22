import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductFacts extends StatelessWidget {
  final Map<String, dynamic> food;
  const ProductFacts(this.food, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('${food['food']}', style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 36), color: Theme.of(context).colorScheme.secondary)),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Theme.of(context).colorScheme.secondary,
            iconSize: 36,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: PageView(
        controller: controller,
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 6, right: 30),
                height: 10,
                color: Theme.of(context).colorScheme.secondary,
              ),

              Card(
                margin: const EdgeInsets.all(30),
                color: Theme.of(context).colorScheme.secondary,
                elevation: 10,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text('Nutritional Values', style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 30), color: Theme.of(context).primaryColor)),
                    ),

                    Container(
                      height: 3,
                      color: Theme.of(context).primaryColor,
                    ),

                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('\n${food['quantity']} serving(s)', style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 16), color: Theme.of(context).primaryColor)),
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Serving size', style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), color: Theme.of(context).primaryColor)),
                          Text('${food['serving']} ${food['unit']}', style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 20), color: Theme.of(context).primaryColor))
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Nutriscore\n', style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), color: Theme.of(context).primaryColor)),
                          Text('${food['nutriscore']}\n', style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 20), color: Theme.of(context).primaryColor))
                        ],
                      ),
                    ),

                    Container(
                      height: 3,
                      color: Theme.of(context).primaryColor,
                    ),

                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('\nAmount per serving', style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 16), color: Theme.of(context).primaryColor)),
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.all(5),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Macros', style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), color: Theme.of(context).primaryColor)),
                            Text('% Daily Value', style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), color: Theme.of(context).primaryColor)),
                          ],
                        ),
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      height: 1,
                      color: Theme.of(context).primaryColor,
                    ),

                    Container(
                      margin: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Calories ', style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), color: Theme.of(context).primaryColor)),
                              Text('${food['calories']} kcal', style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 16), color: Theme.of(context).primaryColor))
                            ],
                          ),
                          Text('${food['calories']/25}%', style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 16), color: Theme.of(context).primaryColor)),
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      height: 1,
                      color: Theme.of(context).primaryColor,
                    ),

                    Container(
                      margin: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Carbohydrates ', style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), color: Theme.of(context).primaryColor)),
                              Text('${food['carbs']}g', style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 16), color: Theme.of(context).primaryColor))
                            ],
                          ),
                          Text('${food['carbs']/2.5}%', style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 16), color: Theme.of(context).primaryColor)),
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      height: 1,
                      color: Theme.of(context).primaryColor,
                    ),

                    Container(
                      margin: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Fat ', style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), color: Theme.of(context).primaryColor)),
                              Text('${food['fat']}g', style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 16), color: Theme.of(context).primaryColor))
                            ],
                          ),
                          Text('${food['fat']*5}%', style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 16), color: Theme.of(context).primaryColor)),
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      height: 1,
                      color: Theme.of(context).primaryColor,
                    ),

                    Container(
                      margin: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Protein \n', style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), color: Theme.of(context).primaryColor)),
                              Text('${food['protein']}g\n', style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 16), color: Theme.of(context).primaryColor))
                            ],
                          ),
                          Text('${food['protein']/0.6}%\n', style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 16), color: Theme.of(context).primaryColor)),
                        ],
                      ),
                    ),

                    Container(
                      height: 3,
                      color: Theme.of(context).primaryColor,
                    ),

                    Container(
                      margin: const EdgeInsets.only(
                          left: 5, right: 5, top: 5, bottom: 5),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            Text('\nIngredients', textAlign: TextAlign.center,style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), color: Theme.of(context).primaryColor)),
                            Text('${food['ingredients']}\n', textAlign: TextAlign.center, style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 16), color: Theme.of(context).primaryColor))
                          ],
                        ),
                      ),
                    ),

                    Container(
                      height: 3,
                      color: Theme.of(context).primaryColor,
                    ),

                    Container(
                      margin: const EdgeInsets.only(
                          left: 5, right: 5, top: 5, bottom: 5),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            Text('\nAllergens', textAlign: TextAlign.center,style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), color: Theme.of(context).primaryColor)),
                            Text('None\n', textAlign: TextAlign.center, style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 16), color: Theme.of(context).primaryColor))
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ),

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Swipe Right    ', style: GoogleFonts.barlow(textStyle: const TextStyle(fontSize: 20), color: Theme.of(context).colorScheme.secondary)),
                    Icon(Icons.arrow_forward_ios, color: Theme.of(context).colorScheme.secondary,),
                  ],
                ),
              ),
            ],
          ),

          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 6, right: 30),
                height: 10,
                color: Theme.of(context).colorScheme.secondary,
              ),

              Container(
                margin: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                border: Border.all(color: Theme.of(context).colorScheme.secondary),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Eco Rating', style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold)),
                        Text('${food['eco_rating']}', style: const TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    height: 5,
                    color: Colors.black,
                  ),

                  Container(
                    margin: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Carbon Footprint ', style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('${food['kg_co2_eq']}kg', style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    height: 1,
                    color: Colors.black,
                  ),

                  Container(
                    margin: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Land Use', style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('${food['land_use']}m²', style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    height: 1,
                    color: Colors.black,
                  ),

                  Container(
                    margin: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Freshwater Use', style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('${food['water_use']}L', style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    height: 1,
                    color: Colors.black,
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          const Text(
                              'Additional Information',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)
                          ),

                          Text(
                            '${food['additional_info']}',
                            textAlign: TextAlign.center,
                            //overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 16)
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
    );
  }
}