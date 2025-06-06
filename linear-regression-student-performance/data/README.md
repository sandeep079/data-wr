### Summary of the Assignment

In this assignment, we trained a linear regression model to predict students' final grades (G3) based on various features from a dataset containing information about students' demographics, academic performance, and social factors. The process involved several key steps, which are summarized below:

1. **Import Libraries**: We imported necessary libraries such as `numpy`, `pandas`, and `matplotlib`.

2. **Load Data**: The dataset was loaded from a specified URL into a pandas DataFrame.

3. **Train-Test Split**: The dataset was split into features (X) and target (y) variables, and then further divided into training and testing sets using an 80-20 ratio.

4. **Data Visualization**: We plotted histograms to visualize the distribution of various features and scatter plots to analyze relationships between features and the target variable.

5. **Correlation Analysis**: We computed the correlation of numerical features with the target variable (G3) to identify the most influential features.

6. **Model Training**: 
   - We first trained a linear regression model using the top five features that showed the strongest correlation with G3.
   - We then preprocessed the data to include all features, applying label encoding for categorical variables and one-hot encoding for nominal variables.

7. **Model Evaluation**: We evaluated the model's performance using metrics such as Root Mean Squared Error (RMSE) and Mean Absolute Error (MAE).

8. **Baseline Model**: We created a baseline model that predicts the mean of the training data to compare the performance of our linear regression model.

### Key Findings

- The top five features that were most correlated with the final grade (G3) were:
  - G2 (second period grade)
  - G1 (first period grade)
  - Failures (number of past class failures)
  - Mother's education (Medu)
  - Age

- The linear regression model trained on all features achieved an RMSE of approximately 2.42 and an MAE of about 1.61, indicating a reasonable level of predictive accuracy.

- The baseline model, which simply predicts the mean of the training data, had an RMSE of approximately 5.26 and an MAE of about 4.12. This shows that our linear regression model performed significantly better than the baseline model.

### Conclusion

The assignment demonstrated the process of building a predictive model using linear regression, including data preprocessing, feature selection, model training, and evaluation. The results indicate that the model can effectively predict students' final grades based on various factors, and it outperforms a simple baseline model. This exercise highlights the importance of feature selection and the impact of different variables on academic performance.