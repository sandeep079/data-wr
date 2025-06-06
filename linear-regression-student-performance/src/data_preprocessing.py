### Summary of the Assignment

In this assignment, we trained a linear regression model to predict students' final grades (G3) based on various features from a dataset containing information about students' demographics, social background, and academic performance. The process involved several steps, including data preprocessing, feature selection, model training, and evaluation.

### Steps Taken

1. **Import Libraries**: We imported necessary libraries such as NumPy, Pandas, and Matplotlib for data manipulation and visualization.

2. **Load Data**: The dataset was loaded from a provided URL into a Pandas DataFrame.

3. **Train-Test Split**: The dataset was split into features (X) and target (y), followed by an 80-20 split into training and testing sets to prevent data leakage.

4. **Data Visualization**: We plotted histograms to visualize the distribution of various features and scatter plots to analyze relationships between features and the target variable.

5. **Correlation Analysis**: We calculated the correlation of numerical features with the target variable (G3) to identify the most influential features.

6. **Model Training**: 
   - We first trained a linear regression model using the top five features that had the highest correlation with G3.
   - We then preprocessed the data to include all features, applying label encoding for categorical variables and one-hot encoding for nominal variables.

7. **Model Evaluation**: We evaluated the model's performance using metrics such as Root Mean Squared Error (RMSE) and Mean Absolute Error (MAE).

8. **Baseline Model**: We created a baseline model that predicts the mean of the training data to compare the performance of our linear regression model.

### Key Findings

- The top five features that had the strongest correlation with the final grade (G3) were:
  - G2 (0.9089)
  - G1 (0.7881)
  - Failures (-0.3180)
  - Medu (0.2384)
  - Age (-0.1849)

- The linear regression model trained on all features achieved an RMSE of approximately 2.42 and an MAE of approximately 1.61.

- The baseline model, which predicts the mean, had an RMSE of approximately 5.26 and an MAE of approximately 4.12, indicating that our linear regression model performed significantly better than the baseline.

### Conclusion

The linear regression model effectively predicts students' final grades based on various features, and the evaluation metrics indicate that the model is performing well compared to a simple baseline model. Further improvements could be made by exploring more complex models or feature engineering techniques.