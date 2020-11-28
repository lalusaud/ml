# Choose an image
FROM ankane/ml-stack:standard

# Remove example notebooks
RUN rm *.ipynb

RUN bundle install

# Copy your notebooks
COPY ./simple_linear_regression/SimpleLinearRegression-Ruby.ipynb ./
COPY ./multiple_linear_regression/LinearRegression-Ruby.ipynb ./

# The rest is specific to Binder
ARG NB_USER
ARG NB_UID
RUN adduser --disabled-password --gecos '' --uid ${NB_UID} ${NB_USER} && \
    chown -R ${NB_USER}:${NB_USER} .
USER ${NB_USER}
RUN mkdir ~/.jupyter && \
    echo 'c.KernelSpecManager.ensure_native_kernel = False' > ~/.jupyter/jupyter_notebook_config.py && \
    iruby register
