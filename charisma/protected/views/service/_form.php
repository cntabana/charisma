<div class="form">


<?php $form = $this->beginWidget('GxActiveForm', array(
	'id' => 'service-form',
	'enableAjaxValidation' => false,
));
?>

	<p class="note">
		<?php echo Yii::t('app', 'Fields with'); ?> <span class="required">*</span> <?php echo Yii::t('app', 'are required'); ?>.
	</p>

	<?php echo $form->errorSummary($model); ?>

		<div class="row">
		<?php echo $form->labelEx($model,'service'); ?>
		<?php echo $form->textField($model, 'service', array('maxlength' => 50)); ?>
		<?php echo $form->error($model,'service'); ?>
		</div><!-- row -->

		
<?php
echo GxHtml::submitButton(Yii::t('app', 'Save'));
$this->endWidget();
?>
</div><!-- form -->