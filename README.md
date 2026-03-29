# Shoulder Implant Semantic Segmentation using U-Net

This project focuses on the automated detection and segmentation of shoulder implants in X-ray images. Using MATLAB's **Deep Learning Toolbox**, a U-Net architecture was trained to identify the 'Implant' region with high precision.

## Project Overview
- **Goal:** Accurate pixel-level segmentation of shoulder implants.
- **Architecture:** U-Net (Semantic Segmentation).
- **Dataset:** 597 X-ray images.
- **Labeling:** Manually labeled using **Image Labeler** (Polygon labels) with a bootstrap AI-assisted workflow.

## Repository Structure
- `data/`: Contains sample X-ray images (anonymized).
- `scripts/`: MATLAB scripts for training and inference (`Final_Implant_Scanner.m`).
- `ImageLabelingProject.prj`: The full Image Labeler project for auditing or extending labels.
- `MasterImplantAI_Final.mat`: The trained U-Net model / Ground Truth data.

## Requirements
To run this project, you need MATLAB (R2023b or later recommended) with the following toolboxes:
1. **Deep Learning Toolbox**
2. **Computer Vision Toolbox**
3. **Image Processing Toolbox**

## Author
Gülse Onan
GitHub: https://github.com/onanGulse

*This project was created as part of a Computational Science and AI coursework.*