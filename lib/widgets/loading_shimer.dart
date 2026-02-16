import 'package:flutter/material.dart';
import 'package:indian_hoax_news/utils/app_colors.dart';

class LoadingShimmer extends StatefulWidget {
  @override
  _LoadingShimmerState createState() => _LoadingShimmerState();
}

class _LoadingShimmerState extends State<LoadingShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.cardShadow,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image shimmer
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Container(
                    height: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment(-1.0 + _animation.value, 0),
                        end: Alignment(1.0 + _animation.value, 0),
                        colors: [
                          AppColors.shimmerBase,
                          AppColors.shimmerHighlight,
                          AppColors.shimmerBase,
                        ],
                        stops: [0.0, 0.5, 1.0],
                      ),
                    ),
                  );
                },
              ),

              Padding(
                padding: EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Time badge shimmer
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Container(
                          height: 16,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: LinearGradient(
                              begin: Alignment(-1.0 + _animation.value, 0),
                              end: Alignment(1.0 + _animation.value, 0),
                              colors: [
                                AppColors.shimmerBase,
                                AppColors.shimmerHighlight,
                                AppColors.shimmerBase,
                              ],
                              stops: [0.0, 0.5, 1.0],
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 12),

                    // Title shimmer
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 18,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9),
                                gradient: LinearGradient(
                                  begin: Alignment(-1.0 + _animation.value, 0),
                                  end: Alignment(1.0 + _animation.value, 0),
                                  colors: [
                                    AppColors.shimmerBase,
                                    AppColors.shimmerHighlight,
                                    AppColors.shimmerBase,
                                  ],
                                  stops: [0.0, 0.5, 1.0],
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              height: 18,
                              width: MediaQuery.of(context).size.width * 0.65,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9),
                                gradient: LinearGradient(
                                  begin: Alignment(-1.0 + _animation.value, 0),
                                  end: Alignment(1.0 + _animation.value, 0),
                                  colors: [
                                    AppColors.shimmerBase,
                                    AppColors.shimmerHighlight,
                                    AppColors.shimmerBase,
                                  ],
                                  stops: [0.0, 0.5, 1.0],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 12),

                    // Description shimmer
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 14,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                gradient: LinearGradient(
                                  begin: Alignment(-1.0 + _animation.value, 0),
                                  end: Alignment(1.0 + _animation.value, 0),
                                  colors: [
                                    AppColors.shimmerBase,
                                    AppColors.shimmerHighlight,
                                    AppColors.shimmerBase,
                                  ],
                                  stops: [0.0, 0.5, 1.0],
                                ),
                              ),
                            ),
                            SizedBox(height: 6),
                            Container(
                              height: 14,
                              width: MediaQuery.of(context).size.width * 0.45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                gradient: LinearGradient(
                                  begin: Alignment(-1.0 + _animation.value, 0),
                                  end: Alignment(1.0 + _animation.value, 0),
                                  colors: [
                                    AppColors.shimmerBase,
                                    AppColors.shimmerHighlight,
                                    AppColors.shimmerBase,
                                  ],
                                  stops: [0.0, 0.5, 1.0],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 12),

                    // Read more shimmer
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Container(
                          height: 14,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            gradient: LinearGradient(
                              begin: Alignment(-1.0 + _animation.value, 0),
                              end: Alignment(1.0 + _animation.value, 0),
                              colors: [
                                AppColors.shimmerBase,
                                AppColors.shimmerHighlight,
                                AppColors.shimmerBase,
                              ],
                              stops: [0.0, 0.5, 1.0],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
