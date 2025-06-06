### Summary of the Assignment

In this assignment, we trained a linear regression model to predict students' final grades (G3) based on various features from a dataset containing student performance data. The process involved several steps, including data preprocessing, model training, evaluation, and comparison with a baseline model.

### Steps Taken

1. **Import Libraries**: We imported necessary libraries such as NumPy, Pandas, and Matplotlib for data manipulation and visualization.

2. **Load Data**: The dataset was loaded from a specified URL into a Pandas DataFrame.

3. **Train-Test Split**: The dataset was split into features (X) and target (y), followed by an 80-20 split into training and testing sets to prevent data leakage.

4. **Data Visualization**: We plotted histograms to visualize the distribution of various features and scatter plots to analyze relationships between features and the target variable.

5. **Correlation Analysis**: We computed the correlation of numerical features with the target variable (G3) to identify the most influential features.

6. **Model Training**: 
   - We first trained a linear regression model using the top five features that showed the strongest correlation with G3.
   - We then preprocessed the data to include all features, applying label encoding for categorical variables and one-hot encoding for nominal variables.

7. **Model Evaluation**: We evaluated the model using metrics such as Root Mean Squared Error (RMSE) and Mean Absolute Error (MAE) to assess prediction accuracy.

8. **Baseline Model**: We created a baseline model using `DummyRegressor` that predicts the mean of the training data, allowing us to compare the performance of our linear regression model against a simple prediction strategy.

### Key Results

- **Top Features Correlation**:
  - G2: 0.908877
  - G1: 0.788115
  - Failures: -0.318010
  - Medu: 0.238431
  - Age: -0.184941

- **Model Performance**:
  - RMSE for the model using top five features: approximately 2.34
  - RMSE for the model using all features: approximately 2.42
  - RMSE for the baseline model: approximately 5.26

- **MAE for the model using all features**: approximately 1.61
- **MAE for the baseline model**: approximately 4.12

### Conclusion

The linear regression model performed significantly better than the baseline model, indicating that the features used in the model are indeed predictive of students' final grades. The model's RMSE and MAE values suggest a reasonable level of accuracy, although there is room for improvement. Further feature engineering, hyperparameter tuning, or exploring more complex models could enhance predictive performance.