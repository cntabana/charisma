<div class="form">


<?php $form = $this->beginWidget('GxActiveForm', array(
	'id' => 'province-form',
	'enableAjaxValidation' => true,
));
?>

	<p class="note">
		<?php echo Yii::t('app', 'Fields with'); ?> <span class="required">*</span> <?php echo Yii::t('app', 'are required'); ?>.
	</p>

	<?php echo $form->errorSummary($model); ?>

		<div class="row">
		<?php echo $form->labelEx($model,'province'); ?>
		<?php echo $form->textField($model, 'province', array('maxlength' => 30)); ?>
		<?php echo $form->error($model,'province'); ?>
		</div><!-- row -->

<?php
echo GxHtml::submitButton(Yii::t('app', 'Save'));
$this->endWidget();
?>
</div><!-- form -->