FROM mcr.microsoft.com/devcontainers/miniconda:3

# Copy and build the conda environment
COPY environment.yml /tmp/environment.yml
RUN conda env create -f /tmp/environment.yml && conda clean -afy

# Make the environment activate automatically in new shells.
# Source conda's hook first, since /etc/bash.bashrc is read before the
# user's ~/.bashrc (where `conda init` installs the shell function).
RUN echo "source /opt/conda/etc/profile.d/conda.sh && conda activate env445" >> /etc/bash.bashrc