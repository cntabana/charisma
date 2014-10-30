<div class="wide form">

<?php $form = $this->beginWidget('GxActiveForm', array(
	'action' => Yii::app()->createUrl($this->route),
	'method' => 'get',
)); ?>

	<div class="row">
		<?php echo $form->label($model, 'id'); ?>
		<?php echo $form->textField($model, 'id'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'eye'); ?>
		<?php echo $form->textField($model, 'eye', array('maxlength' => 6)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'type'); ?>
		<?php echo $form->textField($model, 'type', array('maxlength' => 12)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'typeofglass'); ?>
		<?php echo $form->textField($model, 'typeofglass', array('maxlength' => 8)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'vision'); ?>
		<?php echo $form->textField($model, 'vision', array('maxlength' => 8)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'lunette'); ?>
		<?php echo $form->textField($model, 'lunette', array('maxlength' => 15)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'interpupillarydistance'); ?>
		<?php echo $form->textField($model, 'interpupillarydistance'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'idinvoice'); ?>
		<?php echo $form->dropDownList($model, 'idinvoice', GxHtml::listDataEx(Invoice::model()->findAllAttributes(null, true)), array('prompt' => Yii::t('app', 'All'))); ?>
	</div>

	<div class="row buttons">
		<?php echo GxHtml::submitButton(Yii::t('app', 'Search')); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- search-form -->
