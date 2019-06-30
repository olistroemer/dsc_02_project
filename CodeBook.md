# Code Book Describing the Data Set Created by run\_analysis.R

This data set summarizes the data originally provided by UCI "Human Activity
Recognition Using Smartphones". The original data set can be found
[here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## Read the Data Into R

```R
data <- read.table("summary.txt")
```

## Variables

* `subject :: integer [1:30]`

    This ID references the subject who performed the activity

* `feature :: character`

    Observed feature. This summarized data set contains only the estimations
    of the mean and the standard deviation from the original data set.

    For a more detailed explaination please refer to the `features_info.txt` in
    the original data set referenced in the above description.

* `walking, walkingupstairs, walkingdownstairs, sitting, standing, laying ::
  numeric [-1.0:1.0]`

    The mean of all the measurements performed by the subject for each of the
    activities.

## Transformations Performed on the Original Data Set

1. Merge the training and the test data.

2. Rename the columns according to the `features.txt`.

3. Filter only the columns regarding the mean and the standard deviation.

4. Aggregate the mean of the features measurements over the activity and the
   performing subject.

5. Transform the table using the activities as column names (variables).

6. Rename the columns with descriptive names using the lowercase labels from
   `activity\_labels.txt` with all characters except a-z stripped out.
