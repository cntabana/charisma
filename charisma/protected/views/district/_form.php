<div class="form">


<?php $form = $this->beginWidget('GxActiveForm', array(
	'id' => 'district-form',
	'enableAjaxValidation' => false,
));
?>

	<p class="note">
		<?php echo Yii::t('app', 'Fields with'); ?> <span class="required">*</span> <?php echo Yii::t('app', 'are required'); ?>.
	</p>

	<?php echo $form->errorSummary($model); ?>

		<div class="row">
		<?php echo $form->labelEx($model,'district'); ?>
		<?php echo $form->textField($model, 'district', array('maxlength' => 20)); ?>
		<?php echo $form->error($model,'district'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'idprovince'); ?>
		<?php echo $form->dropDownList($model, 'idprovince', GxHtml::listDataEx(Province::model()->findAllAttributes(null, true)), array('empty' => '--- Choose---')); ?>
		<?php echo $form->error($model,'idprovince'); ?>
		</div><!-- row -->

	<?php
echo GxHtml::submitButton(Yii::t('app', 'Save'));
$this->endWidget();
?>
</div><!-- form -->