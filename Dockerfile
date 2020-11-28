# Choose an image
FROM ankane/ml-stack:standard

# Remove example notebooks
RUN rm *.ipynb

COPY Gemfile* ./
RUN gem install bundler && bundle install

# Copy your notebooks
COPY ./simple_linear_regression/* ./simple_linear_regression/
COPY ./multiple_linear_regression/* ./multiple_linear_regression/

# The rest is specific to Binder
ARG NB_USER
ARG NB_UID
RUN adduser --disabled-password --gecos '' --uid ${NB_UID} ${NB_USER} && \
    chown -R ${NB_USER}:${NB_USER} .
USER ${NB_USER}
RUN mkdir ~/.jupyter && \
    echo 'c.KernelSpecManager.ensure_native_kernel = False' > ~/.jupyter/jupyter_notebook_config.py && \
    iruby register
