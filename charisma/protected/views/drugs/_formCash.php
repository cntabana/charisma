<div class="form">


<?php $form = $this->beginWidget('GxActiveForm', array(
	'id' => 'drugs-form',
	'enableAjaxValidation' => false,
));
?>

	<p class="note">
		<?php echo Yii::t('app', 'Fields with'); ?> <span class="required">*</span> <?php echo Yii::t('app', 'are required'); ?>.
	</p>

	<?php echo $form->errorSummary($model); ?>

		<div class="row">
		<?php //echo $form->labelEx($model,'drug'); ?>
		<?php echo $form->hiddenField($model, 'drug', array('maxlength' => 50)); ?>
		<?php //echo $form->error($model,'drug'); ?>
		</div><!-- row -->
		<div class="row">
		<?php // echo $form->labelEx($model,'generic'); ?>
		<?php echo $form->hiddenField($model, 'generic'); ?>
		<?php //echo $form->error($model,'generic'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'cash'); ?>
		<?php echo $form->textField($model, 'cash'); ?>
		<?php echo $form->error($model,'cash'); ?>
		</div><!-- row -->
		<div class="row">
		<?php //echo $form->labelEx($model,'availability'); ?>
		<?php echo $form->hiddenField($model, 'availability'); ?>
		<?php //echo $form->error($model,'availability'); ?>
		</div><!-- row -->
		<div class="row">
		<?php //echo $form->labelEx($model,'special'); ?>
		<?php echo $form->hiddenField($model, 'special'); ?>
		<?php //echo $form->error($model,'special'); ?>
		</div><!-- row -->

		
<?php
echo GxHtml::submitButton(Yii::t('app', 'Save'));
$this->endWidget();
?>
</div><!-- form -->